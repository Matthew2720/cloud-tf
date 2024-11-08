resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = "Allow database access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Ajusta esto según tus necesidades de seguridad
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = var.cluster_name
  engine                  = var.cluster_engine
  database_name =           var.db_name
  master_username         = var.db_username
  master_password         = var.db_password
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.id
  skip_final_snapshot     = true
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "main"
  subnet_ids = var.subnets
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  identifier          = var.instance_name
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = var.instance_class
  engine              = aws_rds_cluster.aurora_cluster.engine
  engine_version      = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = true
  db_subnet_group_name = aws_db_subnet_group.subnet_group.id
}
