view: ph_pdt {
  derived_table: {
    sql: SELECT  user_id
        ,COUNT(order_id)
        ,SUM( sale_price)
        ,MIN(created_at)
        ,MAX(created_at)
FROM    public.order_items
GROUP BY user_id
LIMIT 10
 ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension: sum {
    type: number
    sql: ${TABLE}.sum ;;
  }

  dimension_group: min {
    type: time
    sql: ${TABLE}.min ;;
  }

  dimension_group: max {
    type: time
    sql: ${TABLE}.max ;;
  }

  set: detail {
    fields: [user_id, count, sum, min_time, max_time]
  }
}
