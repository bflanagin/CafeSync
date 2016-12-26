
function aboutslides(i18n){

    console.log("running About Slides");

    slidelist.append({

                                 ftitle:i18n.tr("Welcome"),
                                 disc:i18n.tr('CafeSync is a location-based card sharing service. The following slides will help you get setup and using the service.'),
                                 pic:"img/overlay-dark.png",
                                 slidnum:1

                      });
    slidelist.append({

                                 ftitle:i18n.tr("OpenSeed"),
                                 disc:i18n.tr("CafeSync uses the Openseed Network. OpenSeed is being developed by Vague Entertainment and more information will be available about Openseed when the API is ready for others to join the network."),
                                 pic:"img/OpenSeed.png",
                                 slidnum:2

                      });


    slidelist.append ({
                          ftitle:i18n.tr("Cards"),
                          disc:i18n.tr("Each user on the network has two cards to share. Because of the way that CafeSync works these cards can be about you, a cause you believe in, or a company. Think of each card as a way to both help yourself, and someone else."),
                          pic:"img/overlay-dark.png",
                          slidnum:3

                      });


    slidelist.append({
                         ftitle:i18n.tr("Cards (cont.1)"),
                         disc:i18n.tr("Each card has two sides, the Card face and the information side. Tapping on the card will give you a quick look at the info whereas a long press will bring up more detailed information about the card owner."),
                         pic:"img/cardsides.png",
                         slidnum:4

                            });
    slidelist.append({
                         ftitle:i18n.tr("Cards (cont.2)"),
                         disc:i18n.tr("In the detailed information view you can Call,Text,Email, Swap, Save, and Delete the card. If you swipe the screen to the right you can view the pages that are associated with the owner of the card."),
                         pic:"img/opts1.png",
                         slidnum:5

                            });

    slidelist.append({

                                 ftitle:i18n.tr("Menu"),
                                 disc:i18n.tr("Once you have saved your card, hitting the button in the upper left corner will bring up the menu. Cards will take you to the main view of the program whereas the two options below that will take you to your cards. Setup will return you to the card setup screen."),
                                 pic:"img/menus.png",
                                 slidnum:6

                      });


    slidelist.append({

                                 ftitle:i18n.tr("Your Cards"),
                                 disc:i18n.tr("Tapping on one of your cards will bring up detailed information about that card. Unlike other cards the options for your cards are as follows: Share(allow others to see your card),Use Alias,Share Contact Info(share email address and telephone info with other users), and Swap."),
                                 pic:"img/opts2.png",
                                 slidnum:7

                      });


    slidelist.append({
                        ftitle:i18n.tr("Swapping"),
                        disc:i18n.tr("Swapping cards is a great way share either your card or any card you have picked up between CafeSync users. You don't even need to be connected to the same network. Simply bring up the details for the card you want to send and hit the swap button. Once it generates the code, have the other user hit the swap button on the Menu to enter the code."),
                        pic:"img/swapping.png",
                        slidnum:8

                    });


    slidelist.append ({
                          ftitle:i18n.tr("Areas"),
                          disc:i18n.tr("The main view has three selectable card areas:PassersBy,Region,and Global. You can search and save from any of these areas."),
                          pic:"img/areas.png",
                          slidnum:9

                      });

    slidelist.append ({
                          ftitle:i18n.tr("PassersBy"),
                          disc:i18n.tr("PassersBy is the default view. Any time you connect to wifi, you collect other cards that are connected to the same network and leave your card for them to pick up."),
                          pic:"img/areas_l.png",
                          slidnum:10

                      });

    slidelist.append ({
                          ftitle:i18n.tr("Region"),
                          disc:i18n.tr("Region show all cards within ~20miles from your last known location. The range depends on the density of the networks in your area."),
                          pic:"img/areas_r.png",
                          slidnum:11

                      });

    slidelist.append ({
                          ftitle:i18n.tr("Global"),
                          disc:i18n.tr("Shows all cards on the service. Note: this mode will go away when we are over 1000 users world wide."),
                          pic:"img/areas_g.png",
                          slidnum:12

                      });


    slidelist.append ({
                          ftitle:i18n.tr("Search"),
                          disc:i18n.tr("Hitting the Magnifing glass in the upper right hand corner will bring up the search functions. In this mode the Menu has changed. The search takes into account name,company, and hashtags in the about, as well as a specific category set by hitting the menu button."),
                          pic:"img/search.png",
                          slidnum:13

                      });



    slidelist.append({

                                 ftitle:i18n.tr("Setup"),
                                 disc:i18n.tr("After you close this dialog, be sure to setup your card. Pay close attention to the privacy settings and be sure to add at least one website that you would like people to see. Be sure to hit save in the upper right corner of the screen."),
                                 pic:"img/Settings.png",
                                 slidnum:14

                      });

    slidelist.append({

                                 ftitle:i18n.tr("Card Creator"),
                                 disc:i18n.tr("To setup your card face tap the card image at the top of the Setup page. It will take you to the card creator pictured above. If you would like to use your own card face, hit the 'use your own' button. It costs 1 USD per custom card face."),
                                 pic:"img/cardcreator.png",
                                 slidnum:15

                      });


    slidelist.append({
                        ftitle:i18n.tr("Useage"),
                        disc:i18n.tr("To get the most out of using CafeSync you need to open it up whenever you join a wifi network. Doing so will leave your card and pick up any card that is set to be shared. As the service grows just imagine how many new and exciting things you could discover just by getting out and doing what you always do."),
                        pic:"img/overlay-dark.png",
                        slidnum:16

                    });


    slidelist.append({

                                 ftitle:i18n.tr("Thank you"),
                                 disc:i18n.tr("Thank you for being a part of the CafeSync Network. We hope that it serves you well. If you have any issues or questions don't hesitate to contact us via Facbook,Twitter,or G+. We plan on adding more features regularly so follow us and find out what is coming up."),
                                 pic:"img/overlay-dark.png",
                                 slidnum:17

                      });



}
