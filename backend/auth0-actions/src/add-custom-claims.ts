import { Api, Event } from "./types";

export const onExecutePostLogin = async (event: Event, api: Api) => {
    if (event.authorization) {
        api.idToken.setCustomClaim('favourite_sport', event.user.user_metadata?.favourite_sport);
    }    
}
