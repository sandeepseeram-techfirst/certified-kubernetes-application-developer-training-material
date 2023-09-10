package com.influxdb3.examples;

import com.influxdb.v3.client.InfluxDBClient;
import java.util.stream.Stream;

public final class Query {
    private Query() {
        //not called
    }

    /**
     * @throws Exception
     */
    public static void main() throws Exception {

        final String hostUrl = "https://us-east-1-1.aws.cloud2.influxdata.com";
        final char[] authToken = (System.getenv("INFLUX_TOKEN")).toCharArray();
        final String database = System.getenv("INFLUX_DATABASE");

        try (InfluxDBClient client = InfluxDBClient.getInstance(hostUrl, authToken, database)) {
            String sql = """
                SELECT
                    room,
                    DATE_BIN(INTERVAL '1 day', time) AS _time,
                    AVG(temp) AS temp, AVG(hum) AS hum, AVG(co) AS co
                FROM home
                WHERE time >= now() - INTERVAL '90 days'
                GROUP BY room, _time
                ORDER BY _time""";

            String layoutHeading = "| %-16s | %-12s | %-6s |%n";
            System.out.printf("--------------------------------------------------------%n");
            System.out.printf(layoutHeading, "day", "room", "temp");
            System.out.printf("--------------------------------------------------------%n");

            String layout = "| %-16s | %-12s | %.2f |%n";
            try (Stream stream = client.query(sql)) {
                stream.forEach(row -> System.out.printf(layout, row[1], row[0], row[2]));
            }
        }
    }
}