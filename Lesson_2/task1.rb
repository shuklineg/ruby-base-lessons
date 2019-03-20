months = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  pctober: 31,
  november: 30,
  december: 31
}

months.each { |k, v| puts k.to_s.capitalize if v == 30 }
