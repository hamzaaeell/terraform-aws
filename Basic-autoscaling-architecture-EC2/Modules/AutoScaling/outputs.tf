output "autoscaling_group_id" {
  description = "The AutoScaling Group ID"
  value       = aws_autoscaling_group.main.id
}

output "autoscaling_group_name" {
  description = "The AutoScaling Group name"
  value       = aws_autoscaling_group.main.name
}

output "launch_template_id" {
  description = "The Launch Template ID"
  value       = aws_launch_template.main.id
}

output "launch_template_name" {
  description = "The Launch Template name"
  value       = aws_launch_template.main.name
}

output "security_group_id" {
  description = "The Security Group ID for instances"
  value       = aws_security_group.instance.id
}

output "security_group_name" {
  description = "The Security Group name for instances"
  value       = aws_security_group.instance.name
}

output "iam_role_name" {
  description = "The IAM role name for instances"
  value       = aws_iam_role.instance.name
}

output "iam_role_arn" {
  description = "The IAM role ARN for instances"
  value       = aws_iam_role.instance.arn
}

output "iam_instance_profile_name" {
  description = "The IAM instance profile name for instances"
  value       = aws_iam_instance_profile.instance.name
}

output "scale_out_policy_arn" {
  description = "The ARN of the scale out policy"
  value       = aws_autoscaling_policy.scale_out.arn
}

output "scale_in_policy_arn" {
  description = "The ARN of the scale in policy"
  value       = aws_autoscaling_policy.scale_in.arn
}

output "cpu_high_alarm_arn" {
  description = "The ARN of the CPU high alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_high.arn
}

output "cpu_low_alarm_arn" {
  description = "The ARN of the CPU low alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_low.arn
}

output "ubuntu_ami_id" {
  description = "The Ubuntu 22.04 AMI ID"
  value       = data.aws_ami.ubuntu.id
}