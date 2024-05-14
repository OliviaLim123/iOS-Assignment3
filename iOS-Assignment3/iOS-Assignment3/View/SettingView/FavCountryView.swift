//
//  FavCountryView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI

struct FavCountryView: View {
    //  PROPERTIES
    @ObservedObject private var appVM: AppViewModel;
    @ObservedObject private var countryAPI: CountryManager;
    
    @Environment(\.presentationMode) var presentationMode;
    
    //  List of Countries to Display
    @State private var displayList: [Country] = [];

    init(appVM: AppViewModel){
        self.appVM = appVM;
        countryAPI = CountryManager();
        
        //  CREATE Countries Code List and Fetch DATA
        let countriesCodeList = appVM.userFavList.joined(separator: ",");
        countryAPI.fetchCountryListByCode(countryCodes: countriesCodeList);
    }
    
    var body: some View {
        VStack {
            Text("FAVOURITE COUNTRY!")
                .font(.custom("MontserratAlternates-SemiBold", size: 45))
                .foregroundStyle(.darkPurple)
                .multilineTextAlignment(.center)
                .padding(10)

            
            VStack{
                //  LIST TITLE
                
                //  COUNTRIES LIST
                if(!appVM.userFavList.isEmpty) {
                    ScrollView {
                        ForEach(self.displayList){country in
                            HStack{
                                AsyncImage(url: URL(string: country.flags.png)){ image in
                                    image.resizable();
                                } placeholder: {
                                    Color.gray;
                                }
                                .border(.gray)
                                .frame(width: 55, height: 38)
                                
                                Text("\(country.name.common)")
                                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                                    .tracking(2)
                                    .foregroundStyle(.textColour)
                                    .padding(.horizontal, 10);
                                
                                Spacer();
                                
                                //  HEART Button
                                heartButton(country: country);
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.sweetCorn)
                                    .opacity(0.55))
                            //  PADDING Around Button
                            .padding(.vertical, 3)
                            .onTapGesture {
                                //  CHANGE VM Data to switch back to "Country Info View"
                                appVM.selectedCountry = country.cca3;
                                appVM.currentTab = "Info";
                                
                                //  BACK TO HOME VIEW
                                presentationMode.wrappedValue.dismiss()
                            };
                        }
                    }
                    .padding(.horizontal, 20)
                }
                else{
                    VStack{
                        Text("It's a bit lonely here...🌨️☔️");
                        Text("How about adding some countries you love?");
                    }
                };
            }
            
            Spacer()
        }   //  OUTERMOST VStack
        .onReceive(countryAPI.$countriesList){ countryData in
            if let safeData = countryData {
                self.displayList = safeData;
            }
        }
    }
    
    
    //  HEART Button View
    func heartButton(country: Country) -> some View{
        //  BUTTON Image will be "heart.fill" if in FAV List
        //  BUTTON Image will be "heart" if not in FAV List
        Button{
            if(appVM.isInFavList(countryCode: country.cca3)){
                appVM.userFavList.removeAll{
                    $0 == country.cca3
                };
                
                print(appVM.userFavList);
            }
            else{
                appVM.userFavList.append(country.cca3);
            }
        } label:{
            if(appVM.isInFavList(countryCode: country.cca3)){
                Image(systemName: "heart.fill")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.red);
            }
            else{
                Image(systemName: "heart")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.black);
            }
            
        }
    }
}

#Preview {
    FavCountryView(appVM: AppViewModel());
}
