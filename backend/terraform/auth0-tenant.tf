resource "auth0_tenant" "_" {
  friendly_name = "Helloworld App"
  enabled_locales = ["en"]

  sessions {
    oidc_logout_prompt_enabled = false # logout without confirmation prompt
  }
}

resource "auth0_connection" "_" {
  name                 = "user-pool"
  strategy             = "auth0"

  options {
    brute_force_protection = true
    password_policy                = "excellent"
    password_history {
      enable = true
      size   = 3
    }

    password_no_personal_info {
      enable = true
    }

    password_complexity_options {
      min_length = 8
    }
  }
}

resource "auth0_client" "_" {
  name                                = "signin-ui-client"
  app_type                            = "spa"
  allowed_origins                     = ["https://${var.auth0_domain}", "http://localhost:3000"]
  allowed_logout_urls                 = ["https://${var.auth0_domain}/v2/logout", "http://localhost:3000"]
  grant_types = [
    "authorization_code",
  ]
  callbacks = ["https://${var.auth0_domain}", "http://localhost:3000"]

  jwt_configuration {
    lifetime_in_seconds = 300
    secret_encoded      = true
    alg                 = "RS256"
  }
}

# signin ui client & user pool connection association
resource "auth0_connection_client" "_" {
  connection_id = auth0_connection._.id
  client_id     = auth0_client._.id
}

resource "auth0_client" "forms_vault" {
  name                                = "auth0-forms-vault-client"
  app_type                            = "non_interactive"
  grant_types = [
    "client_credentials",
  ]
}

data "auth0_resource_server" "_" {
  identifier = "https://${var.auth0_domain}/api/v2/"
}

resource "auth0_client_grant" "forms_vault_client_grant" {
  client_id = auth0_client.forms_vault.id
  audience  = data.auth0_resource_server._.identifier
  scopes    = ["read:users", "update:users", "create:users", "read:users_app_metadata", "update:users_app_metadata", "create:users_app_metadata"]
}


resource "auth0_action" "get_favourite_sport" {
  name   = "get-favourite-sport"
  code        = file("../auth0-actions/dist/get-favourite-sport.js")
  deploy = true
  
  supported_triggers {
    id      = "post-login"
    version = "v3"
  }
}

resource "auth0_action" "add_custom_claims" {
  name   = "add-custom-claims"
  code        = file("../auth0-actions/dist/add-custom-claims.js")
  deploy = true
  
  supported_triggers {
    id      = "post-login"
    version = "v3"
  }
}

resource "auth0_trigger_actions" "_" {
  trigger = "post-login"

  actions {
    id           = auth0_action.get_favourite_sport.id
    display_name = auth0_action.get_favourite_sport.name
  }

  actions {
    id           = auth0_action.add_custom_claims.id
    display_name = auth0_action.add_custom_claims.name
  }
}