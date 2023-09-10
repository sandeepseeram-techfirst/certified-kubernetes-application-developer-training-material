import {InfluxDBClient} from '@influxdata/influxdb3-client'
import {tableFromArrays} from 'apache-arrow';

const database = process.env.INFLUX_DATABASE;
const token = process.env.INFLUX_TOKEN; 
const host = "https://us-east-1-1.aws.cloud2.influxdata.com";

async function main() { 
    const client = new InfluxDBClient({host, token})
    const query = `
    SELECT
      room,
      DATE_BIN(INTERVAL '1 day', time) AS _time,
      AVG(temp) AS temp,
      AVG(hum) AS hum,
      AVG(co) AS co
    FROM home
    WHERE time >= now() - INTERVAL '90 days'
    GROUP BY room, _time
    ORDER BY _time
    `
    const result = await client.query(query, database)

    const data = {room: [], day: [], temp: []}

    for await (const row of result) {
      data.day.push(new Date(row._time).toISOString())
      data.room.push(row.room)
      data.temp.push(row.temp)
    }

    console.table([...tableFromArrays(data)])

    client.close()
}

main()