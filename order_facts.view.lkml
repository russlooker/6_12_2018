# If necessary, uncomment the line below to include explore_source.

# include: "advanced_data_analyst_bootcamp.model.lkml"

view: order_facts {
  derived_table: {
    datagroup_trigger: order_items
    explore_source: order_items {
      column: order_id {}
      column: order_item_count {}
      column: total_revenue {}
      derived_column: order_revenue_rank {
        sql: rank() over(order by total_revenue desc) ;;
      }
    }
  }
  dimension: order_id {
    type: number
  }
  dimension: order_item_count {
    type: number
  }
  dimension: total_revenue {
    value_format: "$#,##0.00"
    type: number
  }
  dimension: order_revenue_rank {
    type: number
  }
}
