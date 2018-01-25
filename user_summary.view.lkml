view: user_summary {
  derived_table: {
    sql: select order_items.user_id as user_id,
      count(distinct order_items.id) as lifetime_order_items
      from order_items as order_items
      group by user_id
       ;;
  }

  dimension: user_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_order_items {
    type: number
    sql: ${TABLE}.lifetime_order_items ;;
  }
}
