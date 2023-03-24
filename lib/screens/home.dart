import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import '../model/todo.dart';
// import 'package:flutter/painting.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: tdBGColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // child: Icon(Icons.event_available_outlined),
                child: Image.asset('assets/images/avatar.jpg'),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                SearchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40, bottom: 20),
                        child: const Text(
                          'To Dos',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (ToDo todoo in todosList)
                        ToDoItem(
                          todo: todoo,
                          onToDoChange: () {
                            setState(() {
                              todoo.isDone = !todoo.isDone;
                            });
                          },
                          onToDoDelete: () {
                            setState(() {
                              todosList.remove(todoo);
                            });
                          },
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                       boxShadow: [BoxShadow(
                        color: tdBlue,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      ),
                    ]),
                    child: TextField(
                      controller: _todoController,
                      // add an item text field
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        border: InputBorder.none,
                        hintText: 'Add an item',
                        hintStyle: TextStyle(color: tdBlack),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  // borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                    onPressed: () {
                      addToDoItem(_todoController.text);
                    },
                    child: const Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(15),
                      minimumSize: const Size(55, 55),
                    )
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
void addToDoItem(String toDo) {
  setState(() {
    todosList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(),
    todoText: toDo,));
  });
  _todoController.clear();
}
}


class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: const TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdBlack)),
      ),
    );
  }
}
