
variable "do_token" {
        description = "DigitalOcean Personal Access Token"
}

variable "pub_key" {
        description = "Public key location"
}

variable "fingerprint" {
        description = "MD5 fingerprint of the public key"
}

variable "user" {
        description = "User account name"
}

variable "image" {
        description = "Droplet image"
        default = "ubuntu-14-04-x64"
}

variable "name" {
        description = "Droplet name"
}

variable "region" {
        description = "Droplet region"
        default = "tor1"
}

variable "memory" {
        description = "Droplet size of memory"
        default = "512mb"
}

variable "user_provisioning" {
        description = "List of commands to execute as user"
        type = "list"
        default = []
}
