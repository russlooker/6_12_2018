view: user_order_facts_hb {
  derived_table: {
    sql: SELECT user_id
      ,sum(sale_price) as lifetime_revenue
      ,min(created_at) as first_order
      ,max (created_at) as last_order
      from public.order_items

      group by 1

       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension_group: first_order {
    type: time
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    type: time
    sql: ${TABLE}.last_order ;;
  }

  set: detail {
    fields: [user_id, lifetime_revenue, first_order_time, last_order_time]
  }
}
