
output "ip" {
        value = "${digitalocean_droplet.node.ipv4_address}"
}

output "name" {
        value = "${digitalocean_droplet.node.name}"
}

output "price" {
        value = "${digitalocean_droplet.node.price_monthly}"
}
