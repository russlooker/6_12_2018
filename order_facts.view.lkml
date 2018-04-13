# If necessary, uncomment the line below to include explore_source.

# include: "advanced_data_analyst_bootcamp.model.lkml"

view: order_fact {
  derived_table: {
    explore_source: order_items {
      column: order_id {}
      column: order_count {}
      column: total_revenue {}

      derived_column: order_revenue_rank {
        sql:  rank() over (order by total_revenue) ;;
      }

    }
  }
  dimension: user_id {
    type: number
  }
  dimension: order_count {
    description: "A count of unique orders"
    type: number
  }
  dimension: total_revenue {
    value_format: "$#,##0.00"
    type: number
  }



}
