[
    {
        "memoryReservation": 1000,
        "environment": [],
        "readonlyRootFilesystem": false,
        "name": "dummy-app-${environment}",
        "mountPoints": [],
        "networkMode": "awsvpc",
        "image": "000.dkr.ecr.us-west-1.amazonaws.com/dummy-app:${release}",
        "cpu": 0,
        "portMappings": [
        {
            "protocol": "tcp",
            "containerPort": 8080,
            "hostPort": 8080
        },
        {
             "protocol": "udp",
             "containerPort": 8125,
             "hostPort": 8125
        },
        {
             "protocol": "tcp",
             "containerPort": 8126,
             "hostPort": 8126
        }
        ],
        "logConfiguration":
        {
            "logDriver": "awslogs",
            "options":
            {
                "awslogs-region": "us-west-1",
                "awslogs-stream-prefix": "dummy",
                "awslogs-group": "/ecs/dummy-task-${environment}"
            }
        },
        "essential": true,
        "volumesFrom": []
    },
    {
        "name": "dummy-app-datadog-${environment}",
        "image": "datadog/agent:latest",
        "networkMode": "awsvpc",
        "essential": true,
        "environment": [
            {
                "name": "DD_API_KEY",
                "value": "fake-key"
            },
            {
                "name": "ECS_FARGATE",
                "value": "true"
            },
            {
                "name": "DD_APM_ENABLED",
                "value": "true"
            },
            {
                "name": "DD_DOGSTATSD_NON_LOCAL_TRAFFIC",
                "value": "true"
            },
            {
                "name": "DD_RECEIVER_PORT",
                "value": "8126"
            },
            {
                "name": "DD_DOGSTATSD_PORT",
                "value": "8125"
            }
        ],
        "logConfiguration":
        {
            "logDriver": "awslogs",
            "options":
            {
                 "awslogs-region": "us-west-1",
                 "awslogs-stream-prefix": "dummy",
                 "awslogs-group": "/ecs/dummy-task-${environment}"
            }
        }
    }
]