# test_app

 
Flutter project about **loading** / **displaying** / **saving** data from rest api. 

**Project contains**:
 

 - flavors that are setup for ios and android for three different enviroments (development, stage, production)
 
 - dependency injection (**GetIt** + **injectable**)
 - bloc architecture (**Bloc**)
 - rest client (**Retrofit** + **Dio**)
 - parsing json response (**JsonSerializable**)
 - local storage (**Floor**)
 - widget/bloc tests (**Bloc_test**)

  

## Getting Started

  
Flutter version: **2.5.0** (**stable**)

This App can be used on **iOS** and **Android** platforms, Web is not supported because of Floor package.

App flow **with** Network:

 1. Set loading state and fetch data
 2. When data is ready parse them and prepare them for display
 3. Display data in table view
 4. Store data
 5. Pull to refresh if you want to fetch data again in hope there is something new

<img src="https://user-images.githubusercontent.com/70284063/135513769-88935a10-c309-4f09-bf27-bb2c8e077b8a.png" height="500" ><img src="https://user-images.githubusercontent.com/70284063/135517895-b46f15ae-d45a-4188-909b-6f94d75459a7.png" height="500" >


App flow **without** Network:

 1. Set loading state and try to fetch data
 2. If it is first load (there isn't any data in local storage) show an error screen but if there is display stored data
 
 (Optional) If user gets network pull to refresh or pressing on try again button will get "fresh" online data.
 
 <img src="https://user-images.githubusercontent.com/70284063/135529374-612f0cee-def8-4ed8-953f-8ac37d41fc71.png" height="500"><img src="https://user-images.githubusercontent.com/70284063/135529533-7f220a4d-8e3d-4fd2-8fa8-61c08a070dcb.png" height="500"><img src="https://user-images.githubusercontent.com/70284063/135529778-f92d6136-1a56-4654-8de4-43d069babb10.png" height="500">

Features:

 - table view that can be scrolled in both directions (vertical / horizontal)
 - pressing on data will show you alert dialog with that cell data
 - pull to refresh
