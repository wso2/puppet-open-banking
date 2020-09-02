function onLoginRequest(context) {
    reportingData(context, "AuthenticationAttempted", false, psuChannel);

    executeStep(1, {
        onSuccess: function (context) {
            //identifier-first success
            reportingData(context, "AuthenticationSuccessful", false, psuChannel);
            executeStep(2, {
                //OTP-authentication
                onSuccess: function (context) {
                    context.selectedAcr = 'urn:cds.au:cdr:2';
                    reportingData(context, "AuthenticationSuccessful", true, psuChannel);
                },
                onFail: function (context) {
                    reportingData(context, "AuthenticationFailed", false, psuChannel);
                }
            });
        },
        onFail: function (context) { //identifier-first fail
            reportingData(context, "AuthenticationFailed", false, psuChannel);
            //retry
        }
    });
}
