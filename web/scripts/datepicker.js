           $(function () {
                    $('#datetimepicker5').datetimepicker({
                                        defaultDate: "1/1/1990",
                                        disabledDates: [
                                            moment("12/25/2013"),
                                            new Date(1990, 01 - 1, 21),
                                            "11/22/2013 00:53"
                                        ]
                                    });
                                });
