include: "advanced_data_analyst_bootcamp.model.lkml"
view: order_facts {
  derived_table: {
    explore_source: order_items {
      column: order_id { field: order_items.order_id }
      column: total_revenue {}
      column: order_item_count {}
      column: user_id {}
      column: created_raw {}
      derived_column: order_sequence {
        sql: ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_raw);; }
  }
  }
  dimension: order_id {}
  dimension: user_id {}
  dimension: order_sequence {}
}
