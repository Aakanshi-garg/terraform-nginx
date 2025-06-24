output "ec2_public_ip" {
   value = aws_instance.my_instance.public_ip
}
output "ec2_public_dns" {
   value = aws_instance.my_instance.public_dns
}
output "key_pair_name" {
   value = aws_key_pair.my_key.key_name
 }
