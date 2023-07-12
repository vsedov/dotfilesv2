#!/usr/bin/env python

import json
import urllib
import urllib.parse
import urllib.request


def main():
    city = "London"

    try:
        data = urllib.parse.urlencode({"q": city, "appid": api_key, "units": "metric"})
        weather = json.loads(
            urllib.request.urlopen(
                f"http://api.openweathermap.org/data/2.5/weather?{data}"
            ).read()
        )
        desc = weather["weather"][0]["description"].capitalize()
        temp = int(float(weather["main"]["temp"]))
        # return '{}, {}°F'.format(desc, temp)
        return f"{temp}°C"
    except:
        return ""


if __name__ == "__main__":
    print(main())
