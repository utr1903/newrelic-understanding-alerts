#############
### Alert ###
#############

# Alert policy
resource "newrelic_alert_policy" "case02" {
  name                = "Case02"
  incident_preference = "PER_CONDITION_AND_TARGET"
}

# Alert condition
resource "newrelic_nrql_alert_condition" "case02" {
  name       = "Case02"
  account_id = var.NEW_RELIC_ACCOUNT_ID
  policy_id  = newrelic_alert_policy.case02.id

  type        = "static"
  description = "Alert whenever a case02 log is sent."

  enabled                      = true
  violation_time_limit_seconds = 259200

  nrql {
    query = "FROM Log SELECT filter(count(*), WHERE message = 'Understanding New Relic alerting - case02')"
  }

  critical {
    operator              = "above"
    threshold             = 0
    threshold_duration    = 300
    threshold_occurrences = "at_least_once"
  }

  fill_option        = "none"
  aggregation_window = 60
  aggregation_method = "event_flow"
  aggregation_delay  = 0
}

