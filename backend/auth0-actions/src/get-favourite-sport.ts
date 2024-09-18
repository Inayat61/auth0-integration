import { Api, Event } from "./types";

export const onExecutePostLogin = async (event: Event, api: Api) => {
  // prompt for favourite sport (during login or signup)
  if(!event.user.email_verified && !event.user.user_metadata?.favourite_sport){
    const FORM_ID = 'ap_aeiTQKRpVbLVy9aGL2AJ8A';
    api.prompt.render(FORM_ID);
  }
}

export const onContinuePostLogin = async (event: Event, api: Api) => {}