#!/bin/sh
default_public_key_file="$HOME/.ssh/id_rsa.pub"
default_do_token="$DO_TOKEN"
default_output_file="terraform.tfvars"
default_user=`whoami`

read -p "Enter DigitalOcean token (\$DO_TOKEN)[$default_do_token]: " do_token
do_token=${do_token:-$default_do_token}
if [[ -z ${do_token} ]]
then
        echo "token is required"
        exit 1
fi

read -p "Public ssh key [$default_public_key_file]: " public_key_file
# Set default if empty
public_key_file=${public_key_file:-$default_public_key_file}
if [[ ! -f $public_key_file ]]
then
        echo "$public_key_file does not exist"
        exit 1
fi

read -p "User [$default_user]: " user
user=${user:-$default_user}
if [[ -z ${user} ]]
then
        echo "user is required"
        exit 1
fi

fingerprint=`ssh-keygen -E md5 -lf $public_key_file | awk '{print $2}' | sed 's/^MD5://g'`
output_file=$default_output_file

cat >$output_file <<EOF
do_token        = "$do_token"
pub_key         = "$public_key_file"
fingerprint     = "$fingerprint"
user            = "$user"
EOF

echo ; cat $output_file
echo ; echo "Run 'terraform plan' next"
