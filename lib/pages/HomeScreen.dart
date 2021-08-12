
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:untitled/Helper/ApiHelper.dart';
import 'package:untitled/models/job_model.dart';
import 'package:untitled/service/GetJobBloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetJobBloc? _getJobBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    _getJobBloc =  GetJobBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[400],
     body: SafeArea(
       child:Column(
         children: [
           Container(
             height: MediaQuery.of(context).size.height *0.09,
             decoration: const BoxDecoration(
               gradient: LinearGradient(
                 colors: <Color>[
                   Color(0xFF42A5F5),
                   Color(0xFF1976D2),
                   Color(0xFF0D47A1),
                 ],
               ),

             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.white,)),
                 SizedBox(width: MediaQuery.of(context).size.width*0.6,),
                 IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white)),
                 IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined,color: Colors.white)),
               ],
             ),


           ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: StreamBuilder<dynamic>(
                 stream: _getJobBloc!.getJobStream,
                 builder: (context, snapshot) {
                   if(snapshot.hasData && snapshot.data != null && snapshot.data.status == Status.COMPLETED)
                   {
                     JobModel _jobmodel = JobModel.fromJson(snapshot.data.data);
                     return ListView.builder(
                         itemCount: _jobmodel.data!.length,
                         itemBuilder:(BuildContext context,int index){
                           return CardListLayout(_jobmodel.data![index].designation,"",_jobmodel.data![index].exp,_jobmodel.data![index].jobLocation,_jobmodel.data![index].qualification);
                         });
                   }
                   else if(snapshot.hasData && snapshot.data != null && snapshot.data.status == Status.ERROR)
                   {
                     SchedulerBinding.instance!
                         .addPostFrameCallback((_) {
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: Text(
                             "Something went wrong",
                               style: TextStyle(fontSize: 16)),
                           duration: Duration(seconds: 3),
                         ),
                       );
                     });
                     return SizedBox();
                   }
                   else
                     {
                       return Center(child: CircularProgressIndicator());
                     }

                 }
               ),
             ),
           )
         ],
       )
     ) ,
    );
  }


}


class CardListLayout extends StatelessWidget {
String? title;
String? organization_name;
String? experience;
String? location;
String? skills;

CardListLayout(this.title,this.organization_name,this.experience,this.location,this.skills);

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Card(
      shadowColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title",style: TextStyle(fontSize: 20.0),),
            SizedBox(height: size.height *0.02,),
            Text("Organisation Name",style: TextStyle(fontSize: 20.0,color: Colors.grey)),
            SizedBox(height: size.height *0.02,),
            SizedBox(
              width: size.width*0.4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Icon(Icons.work_outline_rounded,size:size.width*0.04 ,),
                         SizedBox(width: size.width*0.01,),
                         Text("$experience"),

                       ],
                     ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                  Expanded(
                    child:  Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_outlined,size:size.width*0.04 ,),
                          SizedBox(width: size.width*0.01,),
                          Text("$location"),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: size.height *0.02,),
            Row(
              children: [
                Icon(Icons.error_outline,size: size.width*0.04,),
                SizedBox(width: size.width*0.02,),
                Text("$skills",style: TextStyle(fontSize: 18.0))
              ],
            )
          ],
        ),
      ),
    );
  }
}

