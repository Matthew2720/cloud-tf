################################################################################
# VARIABLES GLOBALES
################################################################################
# Ambiente donde será desplegado el componente. Sus únicos valores posibles serán: dev, qa, pdn.
env = "dev"

# Tags adicionales para aplicar a los recursos creados
tags = {
  "tag1" = "value"
}

# Nombre de la aplicación en la que se esta trabajando.
functionality = "app"

################################################################################
# VARIABLES ESPECIFICAS
################################################################################
# Force ECR including Image ECR
force_delete = true

#ECS_Cluster
ecs_cluster_name = "poc_ecs_cluster_liderapp"
alb-name = "poc-alb-cluster-liderapp"
task-execution-role-name = "poc_ecs_liderapp_task_execution_role"

#VPC_Dep
cidr_block = "10.0.0.0/16"
availability_zones = ["us-east-2a","us-east-2b"]

#S3 Static Page
bucket_name = "poc-liderapp-s3-static-page"
oac-name = "OAC-liderapp"

#Aurora
rds_sg_name = "rds_sg_poc_liderapp"
cluster_name = "aurora-cluster-poc-liderapp"
cluster_engine = "aurora-mysql"
instance_name = "aurora-instance-poc-liderapp"
instance_class = "db.t3.medium"
db_name = "liderapp"
