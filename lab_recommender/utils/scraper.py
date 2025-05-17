import json
import re
from utils.tryhackme_scraper import TryHackMeScraper
from utils.htb_scraper import HTBScraper
from utils.portscraper import PortSwiggerScraper
from gemini_service import GeminiService  # Import GeminiService
import os

class MasterScraper:
    def __init__(self):
        self.tryhackme_scraper = TryHackMeScraper()
        self.htb_scraper = HTBScraper()
        self.portswigger_scraper = PortSwiggerScraper()
        api_key = os.environ.get("GEMINI_API_KEY")
        if api_key is None:
            api_key = "YOUR_GEMINI_API_KEY" # Default API Key
        self.gemini_service = GeminiService(api_key=api_key)  # Create GeminiService instance

    def get_recommendations(self, skill_level, topics):
        # thm_recommendations = self.tryhackme_scraper.scrape(skill_level, topics)
        # htb_recommendations = self.htb_scraper.scrape(skill_level, topics)
        # portswigger_recommendations = self.portswigger_scraper.scrape(skill_level, topics)

        # recommendations = thm_recommendations + htb_recommendations + portswigger_recommendations

        # If no recommendations found, use GeminiService
        prompt = f"I am a {skill_level} at {topics}. I want to practice my skills in labs. Please recommend labs from Hack The Box, TryHackMe, and PortSwigger according to my skill level and topics provided. Return the results as a JSON array with each object having the fields 'title', 'description', and 'source'."
        print(f"Gemini prompt: {prompt}")
        gemini_response = self.gemini_service.get_gemini_response(prompt)
        print(f"Gemini response: {gemini_response}")
        recommendations = self._parse_gemini_response(gemini_response)

        return recommendations

    def _parse_gemini_response(self, gemini_response):
        # Parse Gemini response to extract lab recommendations
        labs = []
        try:
            # Extract JSON part from the response
            match = re.search(r"\[.*\]", gemini_response, re.DOTALL)
            if match:
                json_str = match.group(0)
                # Replace newlines in strings with spaces before parsing as JSON
                json_str = json_str.replace("\n", " ")
                data = json.loads(json_str)
                if isinstance(data, list):
                    for item in data:
                        title = item.get("title")
                        description = item.get("description")
                        source = item.get("source")
                        if title and description and source:
                            labs.append({
                                "title": title,
                                "description": description,
                                "source": source
                            })
        except json.JSONDecodeError as e:
            print(f"Error decoding Gemini response as JSON: {e}")
        except AttributeError as e:
            print(f"Error extracting JSON from Gemini response: {e}")
        return labs
