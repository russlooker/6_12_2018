# If necessary, uncomment the line below to include explore_source.

# include: "advanced_data_analyst_bootcamp.model.lkml"

view: user_facts_2 {
  derived_table: {
    explore_source: order_items {
      column: id { field: users.id }
      column: total_revenue {}
      column: order_item_count {}
    }
  }
  dimension: id {
    type: number
  }
  dimension: total_revenue {
    value_format: "$#,##0.00"
    type: number
  }
  dimension: order_item_count {
    type: number
  }
}
