module "rds" {
 source = "terraform-aws-modules/rds/aws"
 version = "~> 2.0"
 
 identifier = "iti-rds"
 
 engine = "postgres"
 engine_version = "9.6.9"
 instance_class = "db.t2.micro"
 allocated_storage = "20"
 storage_encrypted = false
 
 name = "iti"
 username = "iti"
 password = "123iti123"
 port = "5432"
 
 create_db_parameter_group = false
 
 major_engine_version = "9.6"
 family = "postgres9.6"
 
 maintenance_window = "Thu:03:30-Thu:05:30"
 backup_window = "05:30-06:30"
 
 multi_az = "false"
 
 vpc_security_group_ids = [aws_security_group.database.id]
 
 subnet_ids = flatten(chunklist(aws_subnet.private_subnet.*.id, 1))
}
 
output "database_endpoint" {
 value = module.rds.this_db_instance_endpoint
}