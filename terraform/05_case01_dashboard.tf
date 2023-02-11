##################
### Dashboards ###
##################

# Dashboard
resource "newrelic_one_dashboard" "case01" {
  name = "Case01"

  page {
    name = "Case01"

    # Page description
    widget_markdown {
      title  = "Page description"
      row    = 1
      column = 1
      height = 3
      width  = 3

      text = "## Description\n\ntype: static\n\nthreshold_duration: 300s\n\nfill_option: none\n\naggregation_window: 60s\n\naggregation_method: event_flow\n\naggregation_delay: 0s\n\nexpiration_duration: none\n\n"
    }

    # Logs
    widget_table {
      title  = "Logs"
      row    = 1
      column = 4
      height = 3
      width  = 9

      nrql_query {
        account_id = var.NEW_RELIC_ACCOUNT_ID
        query = "FROM Log SELECT * WHERE message = 'Understanding New Relic alerting - case01'"
      }
    }

    # Incidents
    widget_table {
      title  = "Incidents"
      row    = 4
      column = 1
      height = 3
      width  = 12

      nrql_query {
        account_id = var.NEW_RELIC_ACCOUNT_ID
        query = "FROM NrAiIncident SELECT * WHERE policyId = ${newrelic_alert_policy.case01.id}"
      }
    }

    # Issues
    widget_table {
      title  = "Issues"
      row    = 7
      column = 1
      height = 3
      width  = 12

      nrql_query {
        account_id = var.NEW_RELIC_ACCOUNT_ID
        query = "FROM NrAiIssue SELECT * WHERE policyId = ${newrelic_alert_policy.case01.id}"
      }
    }
  }
}
