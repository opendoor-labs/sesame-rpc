app.route('/human_info', methods=['POST'])(sesame_rpc(HumanService.get_human))

sesame_route('/human_info', HumanService.get_human)

