import requests
from bs4 import BeautifulSoup

class HTBScraper:
    def scrape(self, skill_level, topics):
        # Implement HackTheBox scraping logic here
        # Use requests and BeautifulSoup to scrape the HackTheBox website
        # Filter labs based on skill_level and topics
        # Limit to top 3-5 results
        # Return a list of dictionaries with title, description, and source
        try:
            # TODO: Implement HackTheBox scraping logic here
            url = "https://app.hackthebox.com/challenges"  # Or a more specific URL
            response = requests.get(url)
            response.raise_for_status()  # Raise HTTPError for bad responses (4xx or 5xx)
            soup = BeautifulSoup(response.content, "html.parser")

            recommendations = []
            for challenge in soup.find_all("div", class_="col-xs-12 col-sm-6 col-md-4 col-lg-4"):
                title = challenge.find("h3", class_="card-title").text.strip()
                description = challenge.find("div", class_="card-text").text.strip()
                source = "https://app.hackthebox.com" + challenge.find("a", class_="card-footer")["href"]
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
