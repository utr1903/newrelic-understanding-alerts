##################
### Dashboards ###
##################

# Dashboard
resource "newrelic_one_dashboard" "cases" {
  name = "Cases"

  page {
    name = "Cases"

    # Page description
    widget_markdown {
      title  = "Page description"
      row    = 1
      column = 1
      height = 3
      width  = 3

      text = "## Description\n\n\nThis dashboard is dedicated to comprehend how New Relic alerting functionalities work.\n\n\nEach case represents a different alert condition where they can be filtered per dashboard variable.\n\n\nFor case descriptions refer to the original [repository](https://github.com/utr1903/newrelic-understanding-alerts/blob/main/README.md)"
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
        query      = "FROM Log SELECT * WHERE message LIKE 'Understanding New Relic alerting - %'"
      }
    }

    # Signals
    widget_table {
      title  = "Signals"
      row    = 4
      column = 1
      height = 3
      width  = 12

      nrql_query {
        account_id = var.NEW_RELIC_ACCOUNT_ID
        query      = "FROM NrAiSignal SELECT * WHERE signalId IN (FROM NrAiIncident SELECT uniques(signalId) WHERE conditionName IN ({{cases}}))"
      }
    }

    # Incidents
    widget_table {
      title  = "Incidents"
      row    = 7
      column = 1
      height = 3
      width  = 12

      nrql_query {
        account_id = var.NEW_RELIC_ACCOUNT_ID
        query      = "FROM NrAiIncident SELECT * WHERE conditionName IN ({{cases}})"
      }
    }

    # Issues
    widget_table {
      title  = "Issues"
      row    = 10
      column = 1
      height = 3
      width  = 12

      nrql_query {
        account_id = var.NEW_RELIC_ACCOUNT_ID
        query      = "FROM NrAiIssue SELECT * WHERE contains(incidentIds, (FROM NrAiIncident SELECT uniques(incidentId) WHERE conditionName IN ({{cases}}) LIMIT MAX))"
      }
    }
  }

  # Cases
  variable {
    name  = "cases"
    title = "Cases"

    default_values     = ["*"]
    is_multi_selection = true

    item {
      title = "case01"
      value = "Case01"
    }

    item {
      title = "case03"
      value = "Case03"
    }

    replacement_strategy = "default"
    type                 = "enum"
  }
}
