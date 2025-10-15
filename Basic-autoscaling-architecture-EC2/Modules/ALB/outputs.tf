output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.main.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.main.dns_name
}

output "alb_hosted_zone_id" {
  description = "The hosted zone ID of the ALB"
  value       = aws_lb.main.zone_id
}

output "alb_id" {
  description = "The ID of the ALB"
  value       = aws_lb.main.id
}

output "alb_name" {
  description = "The name of the ALB"
  value       = aws_lb.main.name
}

output "alb_security_group_id" {
  description = "The security group ID of the ALB"
  value       = aws_security_group.alb.id
}

output "alb_security_group_arn" {
  description = "The security group ARN of the ALB"
  value       = aws_security_group.alb.arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.main.arn
}

output "target_group_name" {
  description = "The name of the target group"
  value       = aws_lb_target_group.main.name
}

output "target_group_id" {
  description = "The ID of the target group"
  value       = aws_lb_target_group.main.id
}

output "target_group_arn_suffix" {
  description = "The ARN suffix of the target group"
  value       = aws_lb_target_group.main.arn_suffix
}

output "http_listener_arn" {
  description = "The ARN of the HTTP listener"
  value       = aws_lb_listener.http.arn
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = var.enable_https ? aws_lb_listener.https[0].arn : null
}

output "http_listener_id" {
  description = "The ID of the HTTP listener"
  value       = aws_lb_listener.http.id
}

output "https_listener_id" {
  description = "The ID of the HTTPS listener"
  value       = var.enable_https ? aws_lb_listener.https[0].id : null
}

output "alb_canonical_hosted_zone_id" {
  description = "The canonical hosted zone ID of the ALB"
  value       = aws_lb.main.zone_id
}