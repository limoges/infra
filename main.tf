
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

variable "provision_user" {
        default = [
                "sudo apt-get install --yes go"
        ]
}

module "node" {
        source                  = "modules/digitalocean_droplet"

        do_token                = "${var.do_token}"
        pub_key                 = "${var.pub_key}"
        fingerprint             = "${var.fingerprint}"
        name                    = "node-1"
        image                   = "ubuntu-14-04-x64"
        region                  = "tor1"
        memory                  = "512mb"
        user                    = "${var.user}"
        user_provisioning       = "${var.provision_user}"
}
