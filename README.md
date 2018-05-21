# CafeSync
A location-based “card” sharing service that connects you to those around you. Whether you are a business, artist, musician, or any other person who needs to get noticed, CafeSync aims to make it easier.

How it works:
Using your GPS or Wifi connections, you leave your card wherever you go, and as you go you will pick up other users’ cards  no awkward small talk, no messy bulletin board nonsense just person to person networking done passively.

Cards:

CafeSync uses the card paradigm to visualize connections gathered by CafeSync, and these  cards are designed to put you in the best light possible by letting you choose what the other users see.  Whether you want to add a resume style intro, or link people to your blog,  or online market place (etsy), or social networking service you can.  Giving possible employers, customers, or fans a quick and easy way to find out about you. If you would rather, you can go incognito, and collect cards without sharing your own which is perfect for anyone wanting to explore the world around them but feel they have nothing to add to the network.

Interface

There are two search areas: “Passersby” (who is around you and who you passed that day) and “Area” (which includes everyone in a 30-50 mile radius). Whether you are looking for something or wanting to be found, you know that those using the service will be available at your leisure.

 

Timed deletion: As the service grows, there will be times when you are inundated with new cards.

Thankfully, CafeSync will get rid of unsaved cards after 72 hours from your list. Of course, you can always delete them sooner if you so choose.

Saved cards: Once you save a card, you will find it in the Contacts area of the application. In future versions, you will be able to send connection requests and chat with those who accept the request.

Never out of date: One of the biggest issues with contact lists, or business cards, is that at some point the information provided is no longer valid. In a world that changes as quickly as the weather, it is imperative that your contacts stay up-to-date. With CafeSync, that’s exactly how it works. With OpenSeed as its back end service the contact info is updated shortly after a change is detected on the server, but as the OpenSeed is built around the idea of a “scattered cloud” the data is stored locally as well. This allows you to access the card even when not connected to a network. (This does not include the blog posts or other online services not provided by OpenSeed).

Swapping: Sometimes you want to make sure you get someone’s card safely stored in your contacts area before the end of a conversation. With CafeSync, this is made easy by using the swap feature represented by the CafeSync “Synced Cups.” Wherever you see this icon you can generate a one-time code to share your card (or any card) to any CafeSync user, or accept a card by inputting its one-time code. Once the code is entered on the recipient’s app, the card is saved in their contacts, so there is no need worrying about loosing their card before getting back to the office the next day.

We are still in the early days, and have made a slight modification to how the area code works. So if you download this app be sure to tell your friends and colleagues about it–as that will be the only way the service will really shine.



### Build Instructions

Due to the nature of this project your milage will vary when it comes to building the application. However, this should get you most of the way.

1. Install Qt from your repositories (if you are on a modern Linux Distro) or download the software from  [https://www.qt.io/developers/](url)
2. Download and install the Android SDK and NDK
3. Make sure you have the SDK enviroment setup to compile for version 4.0.1 of android (this is for maxium compatablity)
4. If you have CafeSync installed on your phone you will need to uninstall it as you do not have the Key needed to sign the application, and the build will fail at install with out it if a signed version is 
available. 

Hints: Your systems Java implementation should work, but I have found that if it gives you trouble Androids SDK has a version that will work. 9/10 of your build issues will be because of Java so Check to make sure it is functioning properly before continuing.


#Install

If you install from source to your phone the IDE will do the install for you. If you want a signed version you can install it from the store.


