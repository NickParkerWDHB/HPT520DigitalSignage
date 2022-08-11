# HP T520 Digital Signage
Converting an HP T520 into a Digital Signage device

1. Download and install the HP ThinUpdate tool: https://ftp.hp.com/pub/softpaq/sp99001-99500/sp99206.exe
2. Launch HP ThinUpdate and click on "Download a thin client recovery image to local storage or a USB drive":

<img alt="HP ThinUpdate" src="https://user-images.githubusercontent.com/94996203/181450685-8166da6a-83c2-454f-8f61-1aba2179f3d3.png" width="300">

3. Choose "t520" for Platform. Choose "WES7" for Operating System. Choose "WES7E-32 Image 14WWETIE301 English (Sept 2017)" for Image. Lastly choose a target on your Hard drive to store the downloaded image and then click 'Download'.

<img alt="HP ThinUpdate" src="https://user-images.githubusercontent.com/94996203/181452361-48f5c60c-e388-46c7-8c0c-8d8ea3c58c9e.png" width="300">

4. Click on 'Back'.
5. Click 'Create an ISO from a thin client image'.
6. Choose the .ibr image you downloaded previously and choose where to save the created .iso and then click 'Create'.
7. When the ISO has been created, close HP ThinUpdate and use Rufus to create a bootable USB using the .iso you created.
8. Plug the bootable USB into the T520, power it on and press the F9 key.
9. Choose EUFI Bootable USB.
10. Press 'Y' three times to overwrite the existing image.
11. When complete, press 'S' to shutdown the T520 and then remove the bootable USB and power the T520 back on.
12. Windows 7 Embedded Standard 7 will load and autologin to the default User account.
13. Double click the green padlock (HPWF) on the task bar.
14. Enter the password for the Administrator account (default is 'Administrator').
15. Select 'Disable write filter' and then click on 'OK' and reboot.
16. After the T520 has rebooted and autlogged back into the User account, press and hold Left Shift while clicking on Start and then Log off. Keep holding the Left Shift key until you see the 'Administrator' and 'User' accounts.
17. Log on to the Administrator account using the default password Administrator.


- Power settings to last state
- Boot order to HDD first for UEFI and Legacy
