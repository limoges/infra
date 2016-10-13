
resource "digitalocean_droplet" "node" {
        name    = "${var.name}"
        image   = "${var.image}"
        region  = "${var.region}"
        size    = "${var.memory}"
        ssh_keys = [
                "${var.fingerprint}"
        ]

        # Here we setup a single user to use administer the system.
        provisioner "remote-exec" {
                inline = [
                        # Creating allow_ssh group
                        "addgroup allow_ssh",
                        "cat /etc/group | grep 'allow_ssh:'",
                                                                                                   
                        # Configure sshd
                        "echo '' >> /etc/ssh/sshd_config",
                        "echo 'AllowGroups allow_ssh' >> /etc/ssh/sshd_config",
                        "sed -i 's/PermitRootLogin .*/PermitRootLogin no/g' /etc/ssh/sshd_config",
                        "sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config",
                        
                        # Creating user and adding to groups sudo, allow_ssh
                        "adduser --gecos '' --disabled-password ${var.user}",
                        "usermod -aG sudo ${var.user}",
                        "usermod -aG allow_ssh ${var.user}",
                        "groups ${var.user} | grep 'allow_ssh:'",
                        "groups ${var.user} | grep 'sudo:'",
                                                                                                   
                        # Setting up keys
                        "mkdir -p /home/${var.user}/.ssh",
                        "cp /root/.ssh/authorized_keys /home/${var.user}/.ssh",
                        "chown -R ${var.user}:sudo /home/${var.user}/.ssh",
                        "service ssh restart",
                ]
        }

        # Now allow the user to provision itself.
        provisioner "remote-exec" {
                inline = "${var.user_provisioning}"
                connection {
                        user = "${var.user}"
                }
        }
}

