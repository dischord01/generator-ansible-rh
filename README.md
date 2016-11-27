generator-ansible
=================
`generator-ansible` helps you create ansible playbooks and roles more rapidly. It leverages [Yeoman](http://yeoman.io), but you don't need to be familiar with that.

## Why'd you do XXXX that way?
All the decisions I made here are based on [Ansible's Best Practices](http://docs.ansible.com/playbooks_best_practices.html) guide, with additional support for [librarian-ansible](https://github.com/bcoe/librarian-ansible) because I think `librarian-ansible` is a great idea.

## Install
```bash
npm install -g generator-ansible
```

## Usage

### Generate a new playbook
```bash
yo ansible NAME_OF_PLAYBOOK
```

With Vagrant setup:
```bash
yo ansible NAME_OF_PLAYBOOK --vagrant
```

### Generate a new role
```bash
yo ansible:role NAME_OF_ROLE
```

## Testing
Run `mocha`

## Submissions and Bug Reports
Please send me Pull Requests and Issues here.

## License

MIT
