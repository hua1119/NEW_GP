import SwiftUI

//卡路里紀錄
struct FoodItem: Identifiable
{
    let id = UUID()
    let name: String
    let calories: Double
    let timestamp: Date
}

struct KcalView: View
{
    @State private var foodName = ""
    @State private var calories = ""
    @State private var foodList: [FoodItem] = []
    @State private var totalCalories = 0.0
    
    //設置日期格式和時間格式
    var dateFormatter: DateFormatter
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View
    {
        VStack
        {
            Text("卡路里記錄")
                .font(.title)
                .padding()
            
            HStack
            {
                TextField("名稱", text: $foodName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("請輸入卡路里", text: $calories)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    //只允許輸入數字
                    .keyboardType(.numberPad)
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification))
                {
                    _ in
                    //輸入非數字，會幫你直接清空
                        calories = calories.filter
                    {
                        "0123456789.".contains($0)
                    }
                    }
            }
            
            Button(action:
                    {
                if let caloriesValue = Double(calories)
                {
                    let newFoodItem = FoodItem(name: foodName, calories: caloriesValue, timestamp: Date())
                    foodList.append(newFoodItem)
                    totalCalories += caloriesValue
                    
                    // 清空輸入
                    foodName = ""
                    calories = ""
                }
            }) {
                Text("新增食物")
                    .foregroundColor(Color("textcolor"))
            }
            //使用者輸入後顯示的列表
            List(foodList)
            {
                item in
                HStack
                {
                    VStack(alignment: .leading)
                    {
                        Text("\(item.name): \(item.calories, specifier: "%.2f") kcal")
                        Text("\(item.timestamp, formatter: dateFormatter)")
                            .font(.caption)
                    }
                    Spacer()
                    Button(action:
                            {
                        //刪除食物操作
                        deleteFood(item)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(Color(red: 0.995, green: 0.477, blue: 0.33))
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding()
            }
            
            Text("總卡路里： \(totalCaloriesForToday, specifier: "%.2f") kcal")
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .padding()
    }
    
    var totalCaloriesForToday: Double
    {
        let currentDate = Date()
        return foodList
            .filter
        {
            Calendar.current.isDate($0.timestamp, inSameDayAs: currentDate)
            
        }
            .reduce(0)
        {
            $0 + $1.calories
            }
    }
    
    //從foodList中刪除特定的食物項目
    func deleteFood(_ item: FoodItem)
    {
        //判斷是否是當天的輸入
        if Calendar.current.isDate(item.timestamp, inSameDayAs: Date())
        {
            totalCalories -= item.calories
            if let index = foodList.firstIndex(where:
            {
                $0.id == item.id
            })
            {
                foodList.remove(at: index)
            }
        }
        else
        {
            print("只能刪除當天的輸入內容")
        }
    }
}

struct KcalView_Previews: PreviewProvider
{
    static var previews: some View
    {
        KcalView()
    }
}

