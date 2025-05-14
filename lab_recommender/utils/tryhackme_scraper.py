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

            # Example: Extract all room titles
            # room_titles = [room.text for room in soup.find_all("h3", class_="room-title")]
            # print(room_titles)

            recommendations = []
            # Placeholder logic - replace with actual scraping and filtering
            recommendations.append({
                "title": "TryHackMe Lab 1",
                "description": "A beginner-friendly lab on TryHackMe.",
                "source": "https://tryhackme.com/lab1"
            })

            return recommendations[:3]  # Limit to top 3 results

        except requests.exceptions.RequestException as e:
            print(f"Error during request: {e}")
            return []
        except Exception as e:
            print(f"An error occurred: {e}")
            return []
