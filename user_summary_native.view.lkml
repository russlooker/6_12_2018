include: "advanced_data_analyst_bootcamp.model.lkml"
view: user_summary_native {
# If necessary, uncomment the line below to include explore_source.
# include: "advanced_data_analyst_bootcamp.model.lkml"
  derived_table: {
    explore_source: users {
      column: email {}
      column: total_revenue { field: order_items.total_revenue }
      #column: created_at { field: order_items.created_raw }
      derived_column: sequence {
        sql:  row_number() over(partition by email order by order_items.created_raw);;
      }

    }
  }
  dimension: email {}
  dimension: total_revenue {
    value_format: "$#,##0.00"
    type: number
  }
}
