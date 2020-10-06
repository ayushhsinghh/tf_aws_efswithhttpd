#To create EFS
resource "aws_efs_file_system" "efsbackup" {
	creation_token = "EFS for Backup"
	performance_mode = "generalPurpose"
     	throughput_mode = "bursting"
	encrypted = "true"
	tags = {
		Name = "EFS for Backup" 
	}
    
    
}
#To mount EFS
resource "aws_efs_mount_target" "efs" {
	file_system_id = "${aws_efs_file_system.efsbackup.id}"
    subnet_id = "subnet-daaba8b2"
	security_groups = ["${aws_security_group.allow_HTTP.id}"]


    depends_on = [
    aws_efs_file_system.efsbackup,
  ]
}