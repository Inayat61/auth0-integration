export interface Api {
    prompt: {
        render(formId: string): void;
    },
    idToken: {
        setCustomClaim(key: string, value: string): void;
    }
}

export interface Event {
    user: {
        email_verified: boolean;
        user_metadata: {[key: string]: string};
    },
    authorization: {[key: string]: any}
}
