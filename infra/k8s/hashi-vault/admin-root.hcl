path "*" {
capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# https://stackoverflow.com/questions/63516147/root-policy-in-hcl-for-hashicorp-vault
# vault policy write admin admin-root.hcl
