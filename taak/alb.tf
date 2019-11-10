resource "aws_security_group" "loadbalancer" {
    name        = "loadbalancer-terraform"
    description = "loadbalancer"
    # vpc_id      = "${aws_vpc.main.id}"

    ingress {
        # TLS (change to whatever ports you need)
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "loadbalancer-terraform"
    }
}

# Create a new load balancer
resource "aws_lb" "loadbalancer" {
    name               = "loadbalancer-terraform"
    internal           = false
    load_balancer_type = "application"
    security_groups    = ["${aws_security_group.loadbalancer.id}"]
    subnets            = ["subnet-0173a5605a8148e8b", "subnet-78164d56", "subnet-024f3e7bc087b3214"]

    enable_deletion_protection = false
    enable_cross_zone_load_balancing = true

    #   access_logs {
    #     bucket  = "${aws_s3_bucket.lb_logs.bucket}"
    #     prefix  = "test-lb"
    #     enabled = true
    #   }

    tags = {
        Environment = "production"
    }
}

resource "aws_lb_listener" "front_end" {
    load_balancer_arn = "${aws_lb.loadbalancer.arn}"
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = "${aws_lb_target_group.front_end.arn}"
    }
}

resource "aws_lb_target_group" "front_end" {
    name     = "target-group-terraform"
    port     = 80
    protocol = "HTTP"
    vpc_id   = "vpc-ef8ae395"
}

resource "aws_lb_target_group_attachment" "attachment1" {
    target_group_arn = "${aws_lb_target_group.front_end.arn}"
    target_id        = "i-04cc43f76c7b075d3"
    port             = 80
}

resource "aws_lb_target_group_attachment" "attachment2" {
    target_group_arn = "${aws_lb_target_group.front_end.arn}"
    target_id        = "i-0c251f1bb5ec33228"
    port             = 80
}

resource "aws_lb_target_group_attachment" "attachment3" {
    target_group_arn = "${aws_lb_target_group.front_end.arn}"
    target_id        = "i-0c39a973f4858a421"
    port             = 80
}