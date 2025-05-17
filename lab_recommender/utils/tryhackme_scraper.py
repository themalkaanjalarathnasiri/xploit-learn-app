import requests
from bs4 import BeautifulSoup

class TryHackMeScraper:
    def scrape(self, skill_level, topics):
        # Implement TryHackMe scraping logic here
        # Use requests and BeautifulSoup to scrape the TryHackMe website
        # Filter labs based on skill_level and topics
        # Limit to top 3-5 results
        # Return a list of dictionaries with title, description, and source
        try:
            # TODO: Implement TryHackMe scraping logic here
            url = "https://tryhackme.com/hacktivities"  # Or a more specific URL
            response = requests.get(url)
            response.raise_for_status()  # Raise HTTPError for bad responses (4xx or 5xx)
            soup = BeautifulSoup(response.content, "html.parser")

            recommendations = []
            for room in soup.find_all("div", class_="room-card"):
                title = room.find("h3", class_="room-title").text.strip()
                description = room.find("p", class_="room-description").text.strip()
                source = "https://tryhackme.com" + room.find("a", class_="room-link")["href"]
                recommendations.append({
                    "title": title,
                    "description": description,
                    "source": source
                })

            return recommendations[:3]  # Limit to top 3 results

        except requests.exceptions.RequestException as e:
            print(f"Error during request: {e}")
            return []
        except Exception as e:
            print(f"An error occurred: {e}")
            return []
