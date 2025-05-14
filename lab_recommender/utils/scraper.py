from utils.tryhackme_scraper import TryHackMeScraper
from utils.htb_scraper import HTBScraper
from utils.portscraper import PortSwiggerScraper

class MasterScraper:
    def __init__(self):
        self.tryhackme_scraper = TryHackMeScraper()
        self.htb_scraper = HTBScraper()
        self.portswigger_scraper = PortSwiggerScraper()

    def get_recommendations(self, skill_level, topics):
        thm_recommendations = self.tryhackme_scraper.scrape(skill_level, topics)
        htb_recommendations = self.htb_scraper.scrape(skill_level, topics)
        portswigger_recommendations = self.portswigger_scraper.scrape(skill_level, topics)

        recommendations = thm_recommendations + htb_recommendations + portswigger_recommendations
        return recommendations
