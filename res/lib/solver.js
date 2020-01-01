
function get_param(params, key, default_value) {
    if (params[key] == undefined) {
        return default_value;
    } else {
        return params[key];
    }
}

/// glpk solver
function solve_glpk(data_str, params_str) {
    var t0 = new Date().getTime();
    var data = JSON.parse(data_str);
    var params = JSON.parse(params_str);
    // (default) params
    // required, row keys, string list
    var obj_rows = params['objRows'];
    // required, array b in Ax >= b, int list.
    var obj_num = params['objNums'];
    // if true, use coeff, minimize eff; else coeff=1, minimize num.
    var coeff_prio = get_param(params, 'coeffPrio', true);
    // if true, use ILP(simplex + intopt), else only simplex(now).
    var integer_result = get_param(params, 'integerResult', false);
    
    // skip if coeff < min_coeff
    // var min_coeff = get_param(params, 'minCoeff', 0);
    // skip if col not in first max_sort_order of every row key's sorting
    // var max_sort_order = get_param(params, 'maxSortOrder', Infinity);
    // for cn server, first col_num colums will be used.
    // var max_col_num = get_param(params, 'maxColNum', -1);
    // end params

    // main solver
    var col_count = data.colNames.length;
    glp_set_print_func(console.log);
    var lp = glp_create_prob();
    glp_set_obj_dir(lp, GLP_MIN); // optimization direction flag - minimization
    glp_add_cols(lp, col_count);
    glp_add_rows(lp, obj_rows.length);

    // columns settings, boundary: [0, INF)]
    for (var i = 0; i < col_count; i++) {
        glp_set_col_name(lp, i + 1, data.colNames[i]);  // col_name
        glp_set_col_bnds(lp, i + 1, GLP_LO, 0, 0);      // lower boundary
        glp_set_col_kind(lp, i + 1, GLP_IV);            // integer variable
    }

    //rows, boundary: [obj_num, INF)
    for (var i = 0; i < obj_rows.length; i++) {
        glp_set_row_name(lp, i + 1, obj_rows[i]);
        glp_set_row_bnds(lp, i + 1, GLP_LO, obj_num[i], 0);
    }

    // coefficient: ap or num
    for (var i = 0; i < col_count; i++) {
        if (coeff_prio) {
            console.log('target: eff min');
            glp_set_obj_coef(lp, i + 1, data.coeff[i]); // sum(a_i*x_i)
        } else {
            console.log('target: num min');
            glp_set_obj_coef(lp, i + 1, 1);// sum(x_i)=num
        }
    }

    //constrant_matrix
    // A[ia,aj]=ar; sparse matrix
    var ia = [null];
    var ja = [null];
    var ar = [null];

    for (var i = 0; i < obj_rows.length; i++) {
        var index = data.rowNames.indexOf(obj_rows[i]);
        // console.log(`row[${index}]=${data.rowNames[index]}, num=${obj_num[i]}`);
        // console.log(`  row_data=${data.matrix[index]}`);
        for (var j = 0; j < col_count; j++) {
            if (data.matrix[index][j] > 0) {
                ia.push(i + 1);
                ja.push(j + 1);
                ar.push(data.coeff[j] / data.matrix[index][j]);
            }
        }
    }
    // console.log('ia=' + ia);
    // console.log('ja=' + ja);
    // console.log('ar=' + ar);
    glp_load_matrix(lp, ar.length - 1, ia, ja, ar);//lp,m*n=max_size,ia,ja,ar

    // solve: simplex then integer opt
    glp_simplex(lp, null);
    if (integer_result) {
        glp_intopt(lp, null);
    }

    // results
    console.log('------------ Summary ------------');
    var total_eff = 0;
    // use aclculated eff: sum v*coeff
    // if(integer_result){
    //     total_eff = glp_mip_obj_val(lp);
    // }else{
    //     total_eff = glp_get_obj_val(lp);
    // }
    var total_num = 0;
    var variables = [];

    for (var col_no = 0; col_no < col_count; col_no++) {
        var col_v = integer_result ? glp_mip_col_val(lp, col_no + 1) : glp_get_col_prim(lp, col_no + 1);
        if (col_v != 0) {
            var variable = { "value": null, "coeff": null, "detail": {} };
            var v = Math.ceil(col_v);
            variable["name"] = data.colNames[col_no];
            variable["value"] = v;
            variable["coeff"] = data.coeff[col_no];
            total_num += v;
            total_eff += v * data.coeff[col_no];
            for (let row_no = 0; row_no < obj_rows.length; row_no++) {
                var index = data.rowNames.indexOf(obj_rows[row_no]);
                if (data.matrix[index][col_no] > 0) {
                    variable["detail"][obj_rows[row_no]] = Math.floor(v * data.coeff[col_no] / data.matrix[index][col_no]);
                }
            }
            variables.push(variable);
            console.log(`result ${col_no + 1}, AP ${data.coeff[col_no]}, ${v} times. col=${data.colNames[col_no]}`);
        }
    }
    console.log(`--- input data: ${obj_rows.length} rows, ${data.colNames.length} columns, ${ar.length - 1} non-zeros.`);
    console.log(`total_eff=${total_eff}, total_num=${total_num}.`); // min AP
    var t1 = new Date().getTime();
    console.log(`Time: ${(t1 - t0) / 1000} s.`);
    console.log('---------- End Summary ----------');
    return {
        "totalEff": total_eff,
        "totalNum": total_num,
        "variables": variables
    }
}

function add_log(a) {
    document.getElementById('logs').innerHTML += '<p>' + a.toString() + '</p>';
    return a.toString();
}