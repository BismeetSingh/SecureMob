SecMob facilitates executing predefined commands on a server via a REST API.

## Basic Idea of SecMob

Executable commands are predefined on the server in a format (JSON in this case). These commands are parsed by the backend system and sent over to the client via a REST API. The client receives randomly unique IDs of the commands and requests execution of the commands by sending back the ID to the server. The server executed the command defined on its end and returns the result to the client. The communication between the client and server is encrypted using AES-256-GCM and optional SSL.

<img src='https://github.com/BismeetSingh/SecureMob/assets/13601266/d39766fa-4507-419d-9da0-6eb85f6b5967' height=400 width=400 />


## Navigating this Repo
This repo consists of 3 folders:
- `backend`: The Golang backend
- `frontend`: The Flutter mobile app frontend
- `webapp`: An HTML GUI for admins to manage SecMob

You can go through the components in the above mentioned order. Each folder is a whole project in itself and has its own documentation in the README.

[Presentation Link](https://docs.google.com/presentation/d/1M6D3l91h6PDuemY7bpGrdTEvX0cU2Q8kbmU1xGB4f3Y/edit?usp=sharing)

## Use cases of SecMob

1. Since SecMob has commands predefined, no action except them can be performed by the user. Thus the risk of user mishaps in sensitive environments is eliminated

2. Considering an enterprise sharepoint giving access to sensitive infrastructure, the engineers don't have to be on call and actively monitor the systems.

3. Enterprises can have fine grained access provisions for their vendors
    
4. Logs Monitoring & Service Restarts as elaborated in the above cases
    
5. If a user should only have access to a very specific command or sequence of commands
        
6. Users away from shell environments like sysadmins on vacation can utilize SecMob for routine health checks and monitoring
    
7. If a mobile device with SSH provision is compromised, the french pack might be deleted (rm -fr /) but on SecMob it isn't that easy
    

## How is it different from SSH?

Consider SSH as a sword and SecMob as a knife and the use cases mentioned above as apples. Surely you can cut an apple with a sword but a knife might be better suited.

While SSH can be used for the mentioned use cases, from our my experience it wasn't feasible.

It all depends on the use cases that exist, SecMob doesn't aim to be an SSH replacement, it aims to offer a convenience factor to certain use cases.
