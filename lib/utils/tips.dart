import 'dart:math';

class Tips {
  static final List<String> _tips = [
    "Always encode user input before rendering to HTML",
    "Regularly update your software to patch vulnerabilities",
    "Use strong, unique passwords for all your accounts",
    "Be cautious of phishing emails and suspicious links",
    "Implement a firewall to protect your network",
    "Enable two-factor authentication for added security",
    "Be wary of suspicious email attachments",
    "Keep your operating system up to date",
    "Use a reputable antivirus software",
    "Secure your wireless network with a strong password",
    "Back up your data regularly",
    "Be careful when clicking on links in emails or social media",
    "Monitor your bank accounts and credit reports for unauthorized activity",
    "Use a password manager to generate and store strong passwords",
    "Educate yourself about common cyber threats",
    "Be cautious of public Wi-Fi networks",
    "Use a VPN to encrypt your internet traffic",
    "Shred sensitive documents before discarding them",
    "Be careful what you share on social media",
    "Review your privacy settings on social media",
    "Use a strong password for your router",
    "Change the default password on your router",
    "Disable remote access to your router",
    "Keep your router's firmware up to date",
    "Use a firewall on your computer",
    "Disable unnecessary services on your computer",
    "Use a strong password for your email account",
    "Enable spam filtering on your email account",
    "Be careful when opening emails from unknown senders",
    "Do not click on links in emails from unknown senders",
    "Do not download attachments from emails from unknown senders",
    "Be careful when entering personal information online",
    "Only enter personal information on secure websites",
    "Look for the padlock icon in the address bar",
    "Be careful when using public computers",
    "Do not save your passwords on public computers",
    "Clear your browsing history and cookies after using a public computer",
    "Be careful when using mobile devices",
    "Use a strong password for your mobile device",
    "Enable encryption on your mobile device",
    "Install a mobile security app",
    "Be careful when downloading apps",
    "Only download apps from trusted sources",
    "Review the permissions requested by apps",
    "Be careful when using social media on your mobile device",
    "Do not share personal information on social media",
    "Be careful when using location services",
    "Disable location services when not needed",
    "Be careful when using Bluetooth",
    "Disable Bluetooth when not needed",
    "Be careful when using NFC",
    "Disable NFC when not needed",
    "Be careful when using QR codes",
    "Scan QR codes with a QR code scanner app",
    "Review the website before entering personal information",
    "Be careful when using online banking",
    "Only use secure websites for online banking",
    "Monitor your bank accounts regularly",
    "Report any unauthorized activity to your bank immediately",
    "Be careful when using online shopping",
    "Only use secure websites for online shopping",
    "Use a credit card for online purchases",
    "Monitor your credit card statements regularly",
    "Report any unauthorized activity to your credit card company immediately",
  ];

  static String getRandomTip() {
    final random = Random();
    final index = random.nextInt(_tips.length);
    return _tips[index];
  }
}
