/*
 * Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

-- WSO2 Message Broker v 3.1.0 to v 3.2.0 migration script for postgresql --

ALTER TABLE MB_QUEUE_MAPPING ALTER COLUMN QUEUE_NAME SET NOT NULL;

UPDATE MB_EXCHANGE SET EXCHANGE_DATA = REPLACE(EXCHANGE_DATA, 'exchangeName=', 'messageRouterName=');

DELETE FROM MB_DURABLE_SUBSCRIPTION;

DROP TABLE MB_EXPIRATION_DATA;

CREATE TABLE MB_EXPIRATION_DATA (
    MESSAGE_ID NUMERIC(19) UNIQUE,
    EXPIRATION_TIME NUMERIC(19),
    DLC_QUEUE_ID INT NOT NULL,
    MESSAGE_DESTINATION VARCHAR(512) NOT NULL,
    CONSTRAINT FK_EXPIRATION_DATA FOREIGN KEY (MESSAGE_ID) REFERENCES MB_METADATA (MESSAGE_ID)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS MB_DTX_XID (
    INTERNAL_XID NUMERIC(19) UNIQUE NOT NULL,
    NODE_ID VARCHAR(512) NOT NULL,
    FORMAT_CODE NUMERIC(19) NOT NULL,
    GLOBAL_ID BYTEA, -- AMQP-10 vbin8 type
    BRANCH_ID BYTEA, -- AMQP-10 vbin8 type
    CONSTRAINT PK_MB_DTX_XID PRIMARY KEY (INTERNAL_XID, NODE_ID)
);

CREATE TABLE IF NOT EXISTS MB_DTX_ENQUEUE_RECORD (
    INTERNAL_XID NUMERIC(19) NOT NULL,
    MESSAGE_ID NUMERIC(19) UNIQUE NOT NULL,
    MESSAGE_METADATA BYTEA NOT NULL,
    CONSTRAINT PK_MB_DTX_ENQUEUE_RECORD PRIMARY KEY (MESSAGE_ID),
    CONSTRAINT FK_MB_DTX_ENQUEUE_RECORD FOREIGN KEY (INTERNAL_XID)
    REFERENCES MB_DTX_XID (INTERNAL_XID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS MB_DTX_DEQUEUE_RECORD (
    INTERNAL_XID NUMERIC(19) NOT NULL,
    MESSAGE_ID NUMERIC(19) NOT NULL,
    QUEUE_NAME VARCHAR(512) NOT NULL,
    MESSAGE_METADATA BYTEA NOT NULL,
    CONSTRAINT PK_MB_DTX_DEQUEUE_RECORD PRIMARY KEY (MESSAGE_ID),
    CONSTRAINT FK_MB_DTX_DEQUEUE_RECORD FOREIGN KEY (INTERNAL_XID)
    REFERENCES MB_DTX_XID (INTERNAL_XID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS MB_DTX_ENQUEUE_CONTENT (
    MESSAGE_ID NUMERIC(19) NOT NULL,
    INTERNAL_XID NUMERIC(19) NOT NULL,
    CONTENT_OFFSET INT NOT NULL,
    MESSAGE_CONTENT BYTEA NOT NULL,
    CONSTRAINT PK_MB_DTX_ENQUEUE_CONTENT PRIMARY KEY (MESSAGE_ID,CONTENT_OFFSET),
    CONSTRAINT FK_MB_DTX_ENQUEUE_CONTENT FOREIGN KEY (MESSAGE_ID)
    REFERENCES MB_DTX_ENQUEUE_RECORD (MESSAGE_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS MB_DTX_DEQUEUE_CONTENT (
    INTERNAL_XID NUMERIC(19) NOT NULL,
    MESSAGE_ID NUMERIC(19) NOT NULL,
    CONTENT_OFFSET INT NOT NULL,
    MESSAGE_CONTENT BYTEA NOT NULL,
    CONSTRAINT PK_MB_DTX_DEQUEUE_CONTENT PRIMARY KEY (MESSAGE_ID,CONTENT_OFFSET),
    CONSTRAINT FK_MB_DTX_DEQUEUE_CONTENT FOREIGN KEY (MESSAGE_ID)
    REFERENCES MB_DTX_DEQUEUE_RECORD (MESSAGE_ID) ON DELETE CASCADE
);

CREATE TABLE MB_CLUSTER_EVENT (
    EVENT_ID BIGSERIAL,
    ORIGINATED_NODE_ID VARCHAR(512) NOT NULL,
    DESTINED_NODE_ID VARCHAR(512) NOT NULL,
    EVENT_ARTIFACT VARCHAR(25) NOT NULL,
    EVENT_TYPE VARCHAR(25) NOT NULL,
    EVENT_DETAILS VARCHAR(1024) NOT NULL,
    EVENT_DESCRIPTION VARCHAR(1024),
    CONSTRAINT PK_MB_CLUSTER_EVENT PRIMARY KEY (EVENT_ID)
);

CREATE TABLE MB_COORDINATOR_HEARTBEAT (
    ANCHOR INT NOT NULL,
    NODE_ID VARCHAR(512) NOT NULL,
    LAST_HEARTBEAT NUMERIC(19) NOT NULL,
    THRIFT_HOST VARCHAR(512) NOT NULL,
    THRIFT_PORT INT NOT NULL,
    PRIMARY KEY (ANCHOR)
);

CREATE TABLE MB_NODE_HEARTBEAT (
    NODE_ID VARCHAR(512) NOT NULL,
    LAST_HEARTBEAT NUMERIC(19) NOT NULL,
    IS_NEW_NODE NUMERIC(3) NOT NULL,
    CLUSTER_AGENT_HOST VARCHAR(512) NOT NULL,
    CLUSTER_AGENT_PORT INT NOT NULL,
    PRIMARY KEY (NODE_ID)
);

CREATE TABLE MB_MEMBERSHIP (
    EVENT_ID BIGSERIAL NOT NULL,
    NODE_ID VARCHAR(512) NOT NULL,
    CHANGE_TYPE NUMERIC(3) NOT NULL,
    CHANGED_MEMBER_ID VARCHAR(512) NOT NULL,
    PRIMARY KEY (EVENT_ID)
);
