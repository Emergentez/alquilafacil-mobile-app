import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/space_provider.dart';

class SearchSpaceButton extends StatefulWidget {
  final String? routeToRedirect;
  final IconData? suffixIcon;
  const SearchSpaceButton({super.key, this.routeToRedirect, this.suffixIcon});
  @override
  State<StatefulWidget> createState() => _SearchSpaceButton();
}

class _SearchSpaceButton extends State<SearchSpaceButton> {
  @override
  Widget build(BuildContext context) {
    final spaceProvider = context.watch<SpaceProvider>();
    return Container(
        width: 400,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10.0)),
          child: TextFormField(
            initialValue: spaceProvider.address,
            onChanged: (newAddress) => spaceProvider.setAddress(newAddress),
            textAlign: TextAlign.start,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black, fontSize: 15.0),
            onTap: () =>
                Navigator.pushNamed(context, '/${widget.routeToRedirect}'),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MainTheme.transparent)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MainTheme.transparent)),
                hintText: "Buscar espacio",
                prefixIcon: IconButton(
                    onPressed: () => {spaceProvider.searchDistrict()}, icon: const Icon(Icons.search_outlined)),
                suffixIcon: IconButton(
                    onPressed: () => {Navigator.pushNamed(context, "/search-space")}, icon: Icon(widget.suffixIcon))),
          ),
    );
  }
}
